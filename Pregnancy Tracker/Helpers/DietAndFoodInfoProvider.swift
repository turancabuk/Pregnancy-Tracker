//
//  DietAndFoodInfoProvider.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 18.04.2024.
//

import UIKit

class DietAndFoodInfoProvider {
    
    static let shared = DietAndFoodInfoProvider()
    
    enum Section {
        case diet
        case food
    }
    
    private init() {}
    func getDietDescription(for section: Section) -> String {
        
        switch section {
        case .diet:
            return dietInfo
        case .food:
            return foodInfo
        }
    }
    
    let dietInfo = """
LEAN MEATS
Lean meats are a crucial part of a healthy pregnancy diet. They are high in essential nutrients such as protein, iron, and B vitamins. These nutrients are vital for both the mother and the developing baby. Lean meat options include chicken breast, turkey, beef, and some types of fish. Cooking methods such as grilling, steaming, or baking can be used to prepare healthy meals. Due to their low-fat content, lean meats also help you control your calorie intake.

Chicken Breast:
Low in fat and a high source of protein, ideal for a variety of dishes.

Turkey:
Particularly its white meat offers a nutritious option with low fat content.

Beef:
The lean cuts are rich in iron and B vitamins, making them excellent choices.

Lean Ground Meat:
Made from lean meats like beef or turkey, suitable for making meatballs and other dishes.

Lamb:
Lean cuts are very rich in protein and iron.

Sirloin Steak:
Another low-fat meat option, perfect for grilling and steaming.

Fish:
Options like salmon, mackerel, and trout are rich in omega-3s, whereas leaner choices such as sea bass and dorado are also beneficial.

AVOCADO
Avocados are a powerhouse of nutrients, offering a substantial supply of healthy fats, fiber, and vitamins such as K, C, E, and B6. These nutrients contribute to heart health, digestive health, and skin vitality. Incorporating avocados into your diet can also help manage weight and stabilize blood sugar levels. Their creamy texture and mild flavor make them a versatile ingredient in many dishes, from breakfasts to salads and even smoothies. Plus, their high content of healthy fats helps improve the absorption of nutrients from other foods eaten with them.

Avocado Toast:
Simple yet satisfying, this dish involves spreading ripe avocado on whole-grain toast, often topped with a sprinkle of salt, pepper, and other toppings like tomatoes or poached eggs.

Guacamole:
A traditional Mexican dip made by mashing ripe avocados with lime juice, onions, tomatoes, and cilantro—perfect for serving with tortilla chips.

Avocado Salad:
Add diced avocados to your favorite salad for a creamy texture and a nutritional boost. They pair well with leafy greens, nuts, and a light vinaigrette.

 

EGGS
Eggs are an excellent source of high-quality protein and contain a wide range of essential nutrients including vitamins D, B12, selenium, and choline. These nutrients are crucial for brain health and maintaining a healthy metabolism. Eggs are also one of the few food sources of vitamin D, which is important for bone health and immune function. Their affordability and versatility make them a staple in diets around the world. Whether incorporated into meals as a main ingredient or used in baking, eggs enhance flavor and nutritional value, making them indispensable in the kitchen.

Scrambled Eggs:
A quick and easy dish, perfect for breakfast. Simply whisk eggs with a little milk, pour into a hot pan, and stir until cooked through. Add herbs, cheese, or vegetables for extra flavor.

Omelette:
Versatile and filling, omelettes can be filled with your choice of vegetables, meats, and cheeses. It’s a great way to use leftover ingredients in your fridge.

Boiled Eggs:
Boil eggs to your desired firmness—soft, medium, or hard. Boiled eggs are a great addition to salads or as a snack on their own.

 

WHEAT
Wheat is a fundamental food grain that is rich in carbohydrates, providing essential energy for daily activities. It also contains protein, fiber, and various vitamins and minerals, such as magnesium, zinc, and B vitamins. These nutrients help support metabolic health and contribute to heart and digestive health. Whole wheat, in particular, is beneficial as it contains the entire grain kernel, which means it has more nutrients compared to refined wheat products. Wheat is incredibly versatile in cooking and baking, forming the base for a wide range of dishes across different cuisines, from breads and pastries to cereals and side dishes. Including whole wheat in your diet can promote a healthier lifestyle by aiding in digestion and maintaining steady blood sugar levels

Whole Wheat Bread:
A healthier alternative to white bread, made with whole wheat flour which retains all parts of the grain and provides more nutrients and fiber.

Pasta:
Available in numerous shapes and forms, whole wheat pasta offers a nutritious twist on traditional pasta, pairing well with a variety of sauces and vegetables.

Wheat Berry Salad:
Cooked wheat berries add a chewy texture to salads. They can be combined with fresh vegetables, nuts, and a tangy dressing for a filling meal.


UNDERCOOKED FOODS
Consuming undercooked foods can pose serious health risks as they may contain harmful bacteria, viruses, or parasites. These pathogens can lead to foodborne illnesses, commonly resulting in symptoms such as nausea, vomiting, diarrhea, and abdominal pain. Vulnerable populations, such as pregnant women, young children, the elderly, and those with weakened immune systems, are particularly at risk. To ensure safety, it is crucial to cook meat, poultry, and eggs to the appropriate temperatures, and to handle raw seafood with care. Always use a food thermometer to check that your food has reached a safe internal temperature before consumption.

Raw Poultry:
Eating undercooked chicken or turkey can lead to salmonella or other bacterial infections.

Rare Hamburgers:
Unlike steak, ground beef should be cooked thoroughly to avoid E. coli and other pathogens.

Soft-Boiled Eggs:
While often safe, they can pose risks if the eggs are contaminated with Salmonella.

Sushi and Sashimi:
Although a popular dish, raw fish must be handled with care to avoid parasites and bacteria.

 

CAFEINE
Caffeine is a stimulant that affects the central nervous system, providing temporary alertness and a boost in energy. While moderate caffeine consumption can be part of a healthy diet, excessive intake may lead to negative health effects such as restlessness, anxiety, heart palpitations, and trouble sleeping. It can also exacerbate certain health conditions like heart disorders or anxiety disorders. Pregnant women are advised to limit their caffeine intake, as it can affect fetal development. To avoid these risks, it is recommended to consume no more than 400 mg of caffeine per day for most healthy adults, which is roughly the amount in four 8-ounce cups of brewed coffee.

Coffee:
The most widely consumed source of caffeine. Depending on the strength, a single cup can contain 95 mg or more of caffeine.

Tea:
Contains caffeine but usually in lower amounts than coffee. Black and green teas have the highest levels.

Energy Drinks:
Often contain high levels of caffeine, along with other stimulants. Can vary significantly in caffeine content.

Cola and Soft Drinks:
These beverages typically contain caffeine. The amount can vary, but it is usually less than coffee or energy drinks.

Chocolate and Chocolate Products:
Contains small amounts of caffeine, especially dark chocolate.

 

RAW FISH

Eating raw fish can be a delightful culinary experience, offering unique textures and flavors. However, consuming raw fish carries certain risks, as it may contain parasites and bacteria that can cause foodborne illnesses. To minimize these risks, it's important to consume raw fish from reputable sources that handle and prepare it according to safe food handling practices. Pregnant women, young children, the elderly, and those with weakened immune systems should avoid raw fish due to increased vulnerability to infections. For those who do choose to eat raw fish, ensuring it has been properly frozen beforehand can kill parasites and reduce the risk of illness.

Sushi and Sashimi:
Traditional Japanese dishes that feature thinly sliced raw fish or seafood.

Ceviche:
A Latin American dish made with raw fish cured in citrus juices, usually lemon or lime, and spiced with chili peppers.

Carpaccio:
An Italian appetizer consisting of thin slices of raw fish or seafood, often dressed with lemon, olive oil, and seasonings.

Tartare:
Typically made from raw tuna or salmon, this dish is chopped and mixed with ingredients like onions, capers, and seasonings.
 

UNDONE MEAT
Consuming undone or undercooked meat poses significant health risks due to the potential presence of harmful bacteria and parasites, such as E. coli, Salmonella, and Trichinella. These pathogens can cause severe foodborne illnesses, manifesting symptoms like severe stomach cramps, diarrhea, and vomiting. Cooking meat to the appropriate internal temperatures ensures that these harmful organisms are killed, making the meat safe to eat. It is especially important to thoroughly cook ground meat, as the grinding process can distribute pathogens throughout. Pregnant women, young children, the elderly, and individuals with weakened immune systems should avoid eating undone meat. Always use a meat thermometer to check that meat has reached the safe minimum internal temperature before consumption.

Rare Steak:
A steak cooked very briefly, so the inside remains red and only slightly warm.

Tartare:
Often made from beef or horse meat, this dish is served raw, seasoned, and sometimes paired with raw egg.

Carpacc
Thinly sliced raw beef or sometimes fish, traditionally served with olive oil, lemon, and capers.

Rare Burgers:
Ground meat that is cooked on the outside but remains pink and raw in the center.

 




"""
    
    let foodInfo = """

VEGATABLES


Vegetables are a cornerstone of healthy eating and are crucial for maintaining overall health. They offer a wide array of benefits, from bolstering the immune system to reducing the risk of chronic diseases such as heart disease, diabetes, and certain cancers. Low in calories yet high in essential nutrients, they help manage body weight and promote healthy skin and hair. Including a variety of vegetables in your diet ensures a broad intake of these health-promoting compounds. Cooking methods like steaming, grilling, or roasting can enhance flavors while preserving their nutritional content.

Rich in Nutrients:
Vegetables provide essential vitamins and minerals, including vitamins A, C, and K, as well as potassium and magnesium.

Dietary Fiber:
High fiber content helps in digestion, prevents constipation, and can aid in weight management.

Antioxidants:
Many vegetables are loaded with antioxidants, which protect the body against oxidative stress and may reduce the risk of chronic diseases.


BEANS

Beans are an incredibly nutritious and versatile food that can play an important role in a healthy diet. They provide a multitude of health benefits, including stabilizing blood sugar levels, supporting heart health, and contributing to fullness, which can aid in weight management. Beans are also rich in several important nutrients such as iron, zinc, magnesium, and B vitamins. They can be easily incorporated into a variety of dishes, from soups and stews to salads and dips, making them a staple in many cuisines around the world. By including beans in your diet, you can enjoy their nutritional benefits while also diversifying your meal options.

Protein Source:
Beans are a great plant-based source of protein, essential for muscle repair and growth.

Fiber Rich:
They contain high levels of dietary fiber, which helps improve digestion and can reduce the risk of chronic diseases.

Heart Health:
Regular consumption of beans can help lower cholesterol levels and reduce heart disease risk due to their low-fat content and high levels of soluble fiber.


AVOCADO

Avocados are a unique fruit that provide a wealth of health benefits. They are particularly known for their healthy fat content, which can help control cholesterol levels and promote heart health. Additionally, the fats in avocados increase the absorption of fat-soluble vitamins and antioxidants from other foods when eaten together. This makes avocados a great addition to meals to ensure you are getting the most out of your dietary intake. Their creamy texture and mild flavor make them versatile in culinary uses, from salads and sandwiches to smoothies and even desserts. Including avocados in your diet can support weight management and provide essential nutrients that contribute to overall health and well-being.

Healthy Fats:
Avocados are rich in monounsaturated fats, which are heart-healthy and help reduce bad cholesterol levels.

Nutrient-Rich:
They contain a wide range of nutrients, including potassium, vitamin E, vitamin K, and various B vitamins.

Fiber Content:
Avocados also provide a good amount of dietary fiber, which aids in digestion and helps maintain a healthy digestive tract.


YOGURT

Yogurt is a highly nutritious food that offers numerous health benefits. Regular consumption can enhance digestive health due to its probiotic content, which helps maintain a healthy balance of gut bacteria. This can also boost the immune system and reduce gastrointestinal issues such as diarrhea and bloating. Additionally, yogurt is a great source of protein and calcium, making it an excellent dietary choice for bone health and overall physical wellness. Its versatility makes it easy to incorporate into your diet through various dishes, whether you prefer it as a breakfast option, a snack, or as an ingredient in smoothies and sauces. By including yogurt in your diet, you can enjoy its delightful taste and numerous health benefits.

Probiotics:
Yogurt is a great source of probiotics, which are beneficial bacteria that support gut health and digestion.

Calcium and Protein:
It is high in calcium, which is essential for strong bones and teeth, and rich in protein, which supports muscle maintenance and repair.

Vitamins and Minerals:
Yogurt contains a spectrum of essential vitamins and minerals, including B vitamins, zinc, and magnesium.


EGGS

Eggs are among the most nutritious foods on the planet, containing a little bit of almost every nutrient you need. They are particularly valued for their high-quality protein, which is important for muscle repair and growth. Eggs also offer a range of other health benefits, such as boosting brain health due to their content of choline, a nutrient that is vital for brain and liver health. Despite concerns about cholesterol, research has shown that moderate egg consumption (up to one egg per day) does not increase heart disease risk in healthy individuals. Additionally, eggs are versatile and easy to cook, making them a convenient and valuable addition to a balanced diet. Whether boiled, poached, scrambled, or used in baking, eggs can enhance any meal with their flavor and nutritional profile.

High-Quality Protein:
Eggs provide complete protein with all the essential amino acids in the right ratios.

Rich in Vitamins and Minerals: 
They are a good source of vitamin B12, vitamin D, riboflavin, and selenium.

Eye Health:
Eggs contain lutein and zeaxanthin, antioxidants that help prevent macular degeneration and cataracts.




ALCOHOL

Alcohol consumption poses significant health risks. While moderate drinking might offer some health benefits, such as potential heart health improvements, the risks often outweigh these benefits. Alcohol impacts nearly every organ in the body and can contribute to several serious health issues, including digestive problems, weakened immune system, and mental health disorders like depression and anxiety. It also increases the risk of developing certain cancers, such as breast, mouth, throat, esophagus, liver, and colon cancer. For pregnant women, any alcohol consumption can adversely affect fetal development, leading to lifelong health problems for the child. Reducing alcohol intake can lead to improved health, better sleep, and enhanced quality of life.

Liver Damage: 
Excessive drinking can lead to a range of liver problems, including cirrhosis and liver cancer.

Addiction Potential:
Alcohol is addictive and can lead to alcohol use disorder, affecting physical and mental health.

Increased Risk of Accidents:
Alcohol impairs coordination and judgment, increasing the risk of accidents and injuries.

Heart Health:
Regular heavy drinking can cause high blood pressure, heart disease, and stroke.


SUSHI & RAW FISH

While sushi and other dishes featuring raw fish are popular worldwide due to their unique flavors and cultural significance, they come with specific health risks. The main concern is the potential presence of parasites and bacteria that can survive in raw fish and cause foodborne illnesses. Proper handling, preparation, and sourcing of high-quality fish from reputable suppliers are essential to minimize these risks. Pregnant women, young children, the elderly, and those with weakened immune systems should be particularly cautious and may want to avoid raw fish altogether. When choosing to eat raw fish, it’s crucial to ensure that it has been handled correctly and frozen properly to kill any parasites present.

Parasitic Infections:
Raw fish can carry parasites like Anisakis, which can cause severe gastrointestinal distress.

Bacterial Contaminations:
Consuming raw or undercooked fish increases the risk of bacterial infections, including salmonella and listeria.

Heavy Metals and Toxins:
Some fish accumulate high levels of mercury and other toxins which can pose health risks.

Allergic Reactions:
Certain raw fish can trigger allergies that may not be evident when the fish is cooked.


CAFEINE

Caffeine is a powerful stimulant found in coffee, tea, energy drinks, and many soft drinks. While moderate caffeine consumption can enhance focus and energy, excessive intake can lead to negative health effects. Overconsumption of caffeine can cause physical symptoms such as jitteriness, headaches, and dizziness. It can also exacerbate underlying heart conditions and may lead to dependence and withdrawal symptoms like fatigue and irritability when caffeine use is reduced. It’s important for individuals, particularly those with certain health conditions or who are sensitive to caffeine, to monitor their intake and adjust it to avoid these adverse effects.

Anxiety and Restlessness:
High doses of caffeine can lead to increased anxiety, restlessness, and even panic attacks.

Sleep Disturbances:
Caffeine can significantly disrupt sleep patterns, leading to insomnia and reduced sleep quality.

Heart Palpitations and Increased Heart Rate:
Excessive caffeine intake can cause heart palpitations and an elevated heart rate.

Digestive Issues:
High amounts of caffeine can lead to gastrointestinal upset, including stomach pain, nausea, and increased acidity.


HALF DONE MEAT

Eating half-done meat comes with significant health risks due to the presence of pathogens that are only eliminated by thorough cooking. These pathogens can cause serious gastrointestinal and systemic illnesses, which are preventable by ensuring meat is cooked to the recommended internal temperatures. Using a meat thermometer is the best way to confirm that meat has reached a safe internal temperature, effectively reducing the risk of infection. It is crucial for individuals, especially those at higher risk such as pregnant women and those with weakened immune systems, to avoid undercooked meat to protect their health.

Bacterial Infections:
Undercooked meat can harbor harmful bacteria such as E. coli, Salmonella, and Campylobacter, leading to severe foodborne illnesses.

Parasitic Infections:
Certain meats, especially pork and wild game, can contain parasites like Trichinella that are not killed unless the meat is fully cooked.

Risk of Toxoplasmosis:
Consuming undercooked or raw meat is a risk factor for toxoplasmosis, which can be particularly dangerous for pregnant women and immunocompromised individuals.


SWEET SNACKS

Sweet snacks, while tempting and often satisfying, carry significant health risks, particularly when consumed in large amounts. These snacks typically offer little nutritional value and are high in sugars and fats, which can lead to various health issues. Overconsumption of sweet snacks disrupts a balanced diet, contributing to nutritional deficiencies and an increased risk of chronic diseases. It is important to moderate the intake of these snacks and consider healthier alternatives, such as fruit or yogurt, to satisfy sweet cravings. For a balanced diet, it’s beneficial to limit processed sugars and instead focus on whole foods that provide essential nutrients.

Weight Gain and Obesity:
High sugar content in sweet snacks can contribute to excessive calorie intake, leading to weight gain and obesity.

Dental Problems:
Frequent consumption of sugary snacks increases the risk of dental cavities and gum disease.

Blood Sugar Spikes:
Sugary snacks can cause rapid spikes in blood sugar levels, leading to energy crashes and can contribute to the development of type 2 diabetes.

Increased Risk of Chronic Diseases:
Regular intake of high-sugar foods is linked to a higher risk of heart disease and other chronic conditions.
"""
    
}
