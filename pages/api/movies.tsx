import clientPromise from "../../lib/mongodb";
import { Request, Response } from 'express';

export default async (req: Request, res: Response) => {
   try {
       const client = await clientPromise;
       const db = client.db("sample_mflix");

       const movies = await db
           .collection("movies")
           .find({})
           .sort({ metacritic: -1 })
           .limit(10)
           .toArray();

       res.json(movies);
   } catch (e) {
       console.error(e);
   }
};