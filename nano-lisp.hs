import           Control.Monad.State.Lazy (State)
import           Data.Map.Lazy            (Map)
import qualified Data.Map.Lazy            as M

---------- Types

data LispTerm = Lit LispLit
              | Var LispVar
              | Pair LispTerm LispTerm
              | Function LispFunction
              | Nil ()

newtype LispLit = LispLit String
newtype LispVar = LispVar String

data LispFunction = LispFunction LispTerm LispTerm

data Env = Env
    { getEnvBindings :: Map LispVar LispTerm
    }

type ProgramState = State Env

evalOnce

eval :: LispTerm -> ProgramState LispTerm
eval (Lit l) = evalOnce $ read l
eval (Var v) = do
    env <- get
    case env !? v of
        Nothing -> error "Attempted to eval free variable!"
        Just value -> return $ eval value
eval (Pair v1 v2) = Pair (eval v1)
eval

-- | Perform substitution of bound variables
-- i.e. replace all LispVars in LispFunction binding
apply :: LispTerm -- ^ Function Expression, single argument with currying.
      -> LispTerm -- ^ Argument
      -> ProgramState LispTerm -- ^ Result
apply (Function (LispFunction (Var v) (Var u))) arg |

main :: IO ()
main = error "TBI"
