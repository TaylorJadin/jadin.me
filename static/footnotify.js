document.addEventListener("DOMContentLoaded", function() {
    const anchors = document.querySelectorAll('a[href^="#fn:"]');
    anchors.forEach(anchor => {
        const id = anchor.getAttribute('href').substring(1);
        const referenceId = `fnref:${id.split(':')[1]}`;
        const reference = document.querySelector(`a[href="#${referenceId}"]`);

        if (reference) {
            // Wrap anchor in a span with id
            const wrapper = document.createElement('span');
            wrapper.id = referenceId;
            anchor.parentNode.insertBefore(wrapper, anchor);
            wrapper.appendChild(anchor);

            // Wrap reference in a span with id
            const refWrapper = document.createElement('span');
            refWrapper.id = id;
            reference.parentNode.insertBefore(refWrapper, reference);
            refWrapper.appendChild(reference);
        }
    });
});