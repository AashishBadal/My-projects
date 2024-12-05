document.addEventListener('DOMContentLoaded', () => {
    const testimonials = [
      {
        name: "John Doe",
        image: "testimonial1.jpg",
        date: "Member since 2020",
        text: "Joining LBEF Sports Club was the best decision ever! The facilities are top-notch, and the coaches are super supportive.",
        rating: 4
      },
      {
        name: "Jane Smith",
        image: "testiminial2.jpg",
        date: "Member since 2018",
        text: "I love the community vibe here! The club not only helps improve your skills but also makes you feel like part of a family.",
        rating: 5
      },
      {
        name: "Mark Taylor",
        image: "testiminial3.jpg",
        date: "Member since 2021",
        text: "Great facilities, professional coaching, and excellent events. Highly recommended for anyone passionate about sports!",
        rating: 4
      }
    ];
  
    const testimonialContainer = document.querySelector('.testimonial-grid');
    testimonialContainer.innerHTML = testimonials
      .map(
        (t) => `
        <div class="testimonial-card">
          <div class="profile">
            <img src="${t.image}" alt="${t.name}" class="profile-img">
            <div class="profile-info">
              <h4>${t.name}</h4>
              <p>${t.date}</p>
            </div>
          </div>
          <p class="testimonial-text">"${t.text}"</p>
          <div class="star-rating">${'★'.repeat(t.rating)}${'☆'.repeat(5 - t.rating)}</div>
        </div>
      `
      )
      .join('');
  });
  