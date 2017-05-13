import express from 'express';

const router = express.Router();


/**
 * Test API
 */
router.route('/something').get((req, res) => {
    res.sendStatus(200);
});

export default router;
