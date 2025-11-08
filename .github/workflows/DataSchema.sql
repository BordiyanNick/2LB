/* --- 1. Таблиця користувачів --- */
CREATE TABLE UserAccount (
    user_id NUMERIC(4),            
    name VARCHAR(50),              
    age NUMERIC(3),                
    gender VARCHAR(10),            
    email VARCHAR(100),           
    password VARCHAR(100)          
);

/* --- 2. Таблиця активності --- */
CREATE TABLE Activity (
    activity_id NUMERIC(4),        
    user_id NUMERIC(4),            
    steps NUMERIC(6),              
    calories_burned FLOAT,         
    sleep_hours FLOAT,             
    date DATE                      
);

/* --- 3. Таблиця харчування --- */
CREATE TABLE Nutrition (
    nutrition_id NUMERIC(4),       
    user_id NUMERIC(4),            
    meal_name VARCHAR(50),         
    calories FLOAT,                
    proteins FLOAT,                
    fats FLOAT,                    
    carbs FLOAT,                   
    date DATE                      
);

/* --- 4. Таблиця аналізу здоров’я --- */
CREATE TABLE HealthAnalysis (
    analysis_id NUMERIC(4),        
    user_id NUMERIC(4),            
    report_date DATE,              
    health_score FLOAT             
);

/* --- 5. Таблиця рекомендацій --- */
CREATE TABLE Recommendation (
    recommendation_id NUMERIC(4),  
    analysis_id NUMERIC(4),        
    text VARCHAR(255),             
    type VARCHAR(50),              
    created_at DATE                
);

/* --- 6. Таблиця музичних ідей --- */
CREATE TABLE MusicIdea (
    idea_id NUMERIC(4),            
    user_id NUMERIC(4),            
    title VARCHAR(100),            
    description VARCHAR(255),      
    audio_path VARCHAR(255)       
);

/* --- 7. Таблиця постів у спільноті --- */
CREATE TABLE CommunityPost (
    post_id NUMERIC(4),            
    user_id NUMERIC(4),            
    content VARCHAR(255),          
    created_at DATE                
);

/* --- 8. Таблиця звітів --- */
CREATE TABLE Report (
    report_id NUMERIC(4),          
    user_id NUMERIC(4),           
    summary_text VARCHAR(255),     
    created_at DATE                
);

----------------------------------------------------------
--                 ОБМЕЖЕННЯ ЦІЛІСНОСТІ
----------------------------------------------------------

/* --- Первинні ключі --- */
ALTER TABLE UserAccount ADD CONSTRAINT user_pk
    PRIMARY KEY (user_id);

ALTER TABLE Activity ADD CONSTRAINT activity_pk
    PRIMARY KEY (activity_id);

ALTER TABLE Nutrition ADD CONSTRAINT nutrition_pk
    PRIMARY KEY (nutrition_id);

ALTER TABLE HealthAnalysis ADD CONSTRAINT analysis_pk
    PRIMARY KEY (analysis_id);

ALTER TABLE Recommendation ADD CONSTRAINT recommendation_pk
    PRIMARY KEY (recommendation_id);

ALTER TABLE MusicIdea ADD CONSTRAINT idea_pk
    PRIMARY KEY (idea_id);

ALTER TABLE CommunityPost ADD CONSTRAINT post_pk
    PRIMARY KEY (post_id);

ALTER TABLE Report ADD CONSTRAINT report_pk
    PRIMARY KEY (report_id);


/* --- Зовнішні ключі --- */
ALTER TABLE Activity ADD CONSTRAINT activity_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);

ALTER TABLE Nutrition ADD CONSTRAINT nutrition_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);

ALTER TABLE HealthAnalysis ADD CONSTRAINT analysis_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);

ALTER TABLE Recommendation ADD CONSTRAINT recommendation_analysis_fk
    FOREIGN KEY (analysis_id) REFERENCES HealthAnalysis (analysis_id);

ALTER TABLE MusicIdea ADD CONSTRAINT idea_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);

ALTER TABLE CommunityPost ADD CONSTRAINT post_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);

ALTER TABLE Report ADD CONSTRAINT report_user_fk
    FOREIGN KEY (user_id) REFERENCES UserAccount (user_id);


/* --- Обмеження змісту (CHECK) --- */
ALTER TABLE UserAccount ADD CONSTRAINT user_age_range
    CHECK (age BETWEEN 10 AND 100);

ALTER TABLE HealthAnalysis ADD CONSTRAINT health_score_range
    CHECK (health_score BETWEEN 0 AND 100);

ALTER TABLE Activity ADD CONSTRAINT activity_sleep_range
    CHECK (sleep_hours BETWEEN 0 AND 24);

ALTER TABLE Activity ADD CONSTRAINT activity_steps_positive
    CHECK (steps >= 0);

/* --- Регулярні вирази (перевірка формату текстових полів) --- */
ALTER TABLE UserAccount ADD CONSTRAINT user_name_format
    CHECK (name ~ '^[A-ZА-ЯІЇЄ][a-zа-яіїє]+$');

ALTER TABLE UserAccount ADD CONSTRAINT user_email_format
    CHECK (email ~ '^([a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\\.[a-z]{2,4})$');
